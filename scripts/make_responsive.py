import re
import sys
import os
from pathlib import Path

def add_screenutil_attributes(content):
    """
    Add flutter_screenutil attributes (.h, .w, .sp, .r) to numeric values in a Dart file.
    """
    
    # First, check if the import already exists
    screenutil_import = "import 'package:flutter_screenutil/flutter_screenutil.dart';"
    
    if screenutil_import not in content:
        # Find the last import statement
        import_pattern = r"^import\s+['\"].*['\"];?\s*$"
        import_matches = list(re.finditer(import_pattern, content, re.MULTILINE))
        
        if import_matches:
            # Get the position after the last import
            last_import = import_matches[-1]
            insert_pos = last_import.end()
            
            # Insert the new import after the last import
            content = content[:insert_pos] + screenutil_import + '\n' + content[insert_pos:]
        else:
            # No imports found, add at the beginning
            content = screenutil_import + '\n\n' + content
    
    # First, let's handle all the property-based conversions
    # This will catch properties in any context (Positioned, EdgeInsets, etc.)
    
    # Width properties - add .w
    content = re.sub(
        r'\bwidth:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'width: \1.w',
        content
    )
    
    # Height properties - add .h
    content = re.sub(
        r'\bheight:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'height: \1.h',
        content
    )
    
    # Top properties - add .h
    content = re.sub(
        r'\btop:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'top: \1.h',
        content
    )
    
    # Bottom properties - add .h
    content = re.sub(
        r'\bbottom:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'bottom: \1.h',
        content
    )
    
    # Left properties - add .w
    content = re.sub(
        r'\bleft:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'left: \1.w',
        content
    )
    
    # Right properties - add .w
    content = re.sub(
        r'\bright:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'right: \1.w',
        content
    )
    
    # Horizontal properties - add .w
    content = re.sub(
        r'\bhorizontal:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'horizontal: \1.w',
        content
    )
    
    # Vertical properties - add .h
    content = re.sub(
        r'\bvertical:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'vertical: \1.h',
        content
    )
    
    # FontSize properties - add .sp
    content = re.sub(
        r'\bfontSize:\s*(\d+(?:\.\d+)?)\b(?!\.\w)',
        r'fontSize: \1.sp',
        content
    )
    
    # Size properties (for icons) - add .r
    content = re.sub(
        r'\bsize:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'size: \1.r',
        content
    )
    
    # BorderRadius.circular - add .r
    content = re.sub(
        r'BorderRadius\.circular\((\d+(?:\.\d+)?)\)',
        r'BorderRadius.circular(\1.r)',
        content
    )
    
    # Radius.circular - add .r
    content = re.sub(
        r'Radius\.circular\((\d+(?:\.\d+)?)\)',
        r'Radius.circular(\1.r)',
        content
    )
    
    # BoxConstraints properties
    content = re.sub(
        r'\bmaxHeight:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'maxHeight: \1.h',
        content
    )
    content = re.sub(
        r'\bmaxWidth:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'maxWidth: \1.w',
        content
    )
    content = re.sub(
        r'\bminHeight:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'minHeight: \1.h',
        content
    )
    content = re.sub(
        r'\bminWidth:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
        r'minWidth: \1.w',
        content
    )
    
    # Handle padding in ElevatedButton.styleFrom and similar
    # This catches standalone padding values in EdgeInsets
    content = re.sub(
        r'EdgeInsets\.symmetric\s*\(\s*vertical:\s*(\d+(?:\.\d+)?)\s*,\s*horizontal:\s*(\d+(?:\.\d+)?)\s*\)',
        r'EdgeInsets.symmetric(vertical: \1.h, horizontal: \2.w)',
        content
    )
    content = re.sub(
        r'EdgeInsets\.symmetric\s*\(\s*horizontal:\s*(\d+(?:\.\d+)?)\s*,\s*vertical:\s*(\d+(?:\.\d+)?)\s*\)',
        r'EdgeInsets.symmetric(horizontal: \1.w, vertical: \2.h)',
        content
    )
    
    # EdgeInsets.only - already handled by individual property patterns above
    
    # EdgeInsets.all - add .w (or .h, typically use .w for uniform padding)
    content = re.sub(
        r'EdgeInsets\.all\((\d+(?:\.\d+)?)\)',
        r'EdgeInsets.all(\1.w)',
        content
    )
    
    # const EdgeInsets.symmetric patterns
    content = re.sub(
        r'const\s+EdgeInsets\.symmetric\s*\(\s*horizontal:\s*(\d+(?:\.\d+)?)\s*\)',
        r'const EdgeInsets.symmetric(horizontal: \1.w)',
        content
    )
    content = re.sub(
        r'const\s+EdgeInsets\.symmetric\s*\(\s*vertical:\s*(\d+(?:\.\d+)?)\s*\)',
        r'const EdgeInsets.symmetric(vertical: \1.h)',
        content
    )
    
    # Remove 'const' keyword from EdgeInsets that now have screenutil attributes
    # Pattern 1: const EdgeInsets with .w or .h
    content = re.sub(
        r'\bconst\s+(EdgeInsets\.[a-zA-Z]+\([^)]*\.\w[^)]*\))',
        r'\1',
        content
    )
    
    # Pattern 2: const in padding/margin with EdgeInsets containing screenutil
    content = re.sub(
        r'\b(padding|margin):\s*const\s+(EdgeInsets\.[a-zA-Z]+\([^)]*\.\w[^)]*\))',
        r'\1: \2',
        content
    )
    
    # Remove duplicate .h.h or .w.w patterns (in case they exist)
    content = re.sub(r'\.h\.h\b', '.h', content)
    content = re.sub(r'\.w\.w\b', '.w', content)
    content = re.sub(r'\.sp\.sp\b', '.sp', content)
    content = re.sub(r'\.r\.r\b', '.r', content)
    
    return content

def find_screen_files(lib_path):
    """
    Find all Dart files containing 'screen' in their names within the lib folder.
    """
    screen_files = []
    
    # Walk through the lib directory
    for root, dirs, files in os.walk(lib_path):
        for file in files:
            # Check if file contains 'screen' (case-insensitive) and is a .dart file
            if 'screen' in file.lower() and file.endswith('.dart'):
                file_path = os.path.join(root, file)
                screen_files.append(file_path)
    
    return sorted(screen_files)

def process_file(dart_file):
    """
    Process a single Dart file and return success status and message.
    """
    try:
        # Read the file
        with open(dart_file, 'r', encoding='utf-8') as f:
            original_content = f.read()
        
        # Check if file already has screenutil import and no bare numbers
        screenutil_import = "import 'package:flutter_screenutil/flutter_screenutil.dart';"
        has_import = screenutil_import in original_content
        
        # Check for any bare numbers that need conversion
        patterns_to_check = [
            r'\bwidth:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
            r'\bheight:\s*(\d+(?:\.\d+)?)\b(?!\.[whr])',
            r'\bfontSize:\s*(\d+(?:\.\d+)?)\b(?!\.\w)',
            r'BorderRadius\.circular\((\d+(?:\.\d+)?)\)(?!\.[whr])',
        ]
        
        has_bare_numbers = any(re.search(pattern, original_content) for pattern in patterns_to_check)
        
        # If has import and no bare numbers, likely already converted
        if has_import and not has_bare_numbers:
            return 'skipped', 'Already converted (has import + no bare numbers)'
        
        # Convert content
        converted_content = add_screenutil_attributes(original_content)
        
        # Double-check if any changes were made
        if original_content == converted_content:
            return 'skipped', 'No changes needed'
        
        # Write back to the same file
        with open(dart_file, 'w', encoding='utf-8') as f:
            f.write(converted_content)
        
        return 'success', 'Converted successfully'
        
    except Exception as e:
        return 'error', str(e)

def print_header():
    """Print a nice header for the script."""
    print("\n" + "=" * 70)
    print("  Flutter ScreenUtil Converter - Batch Processing")
    print("=" * 70 + "\n")

def print_summary(results):
    """Print a summary of the conversion results."""
    print("\n" + "=" * 70)
    print("  CONVERSION SUMMARY")
    print("=" * 70)
    print(f"  Total files found:     {results['total']}")
    print(f"  ✓ Successfully converted: {results['success']} files")
    print(f"  ⊘ Skipped (no changes):   {results['skipped']} files")
    print(f"  ✗ Failed:                 {results['error']} files")
    print("=" * 70 + "\n")

def main():
    # Determine the lib path
    if len(sys.argv) > 1:
        lib_path = sys.argv[1].replace('\\', '/')
    else:
        # Default to 'lib' folder in current directory
        lib_path = 'lib'
    
    # Check if lib folder exists
    if not os.path.exists(lib_path):
        print(f"❌ Error: '{lib_path}' folder not found")
        print("   Make sure you're in the project root directory or provide the correct path")
        print("   Usage: python screenutil_converter.py [lib_folder_path]")
        sys.exit(1)
    
    print_header()
    print(f"🔍 Searching for screen files in: {os.path.abspath(lib_path)}\n")
    
    # Find all screen files
    screen_files = find_screen_files(lib_path)
    
    if not screen_files:
        print("⚠️  No files containing 'screen' in their names were found in the lib folder")
        sys.exit(0)
    
    print(f"📁 Found {len(screen_files)} file(s) to process:\n")
    
    # Display found files
    for i, file in enumerate(screen_files, 1):
        rel_path = os.path.relpath(file, lib_path)
        print(f"   {i}. {rel_path}")
    
    print("\n" + "-" * 70 + "\n")
    print("🚀 Starting conversion process...\n")
    
    # Process each file
    results = {'total': len(screen_files), 'success': 0, 'skipped': 0, 'error': 0}
    
    for i, file in enumerate(screen_files, 1):
        rel_path = os.path.relpath(file, lib_path)
        print(f"[{i}/{len(screen_files)}] Processing: {rel_path}")
        
        status, message = process_file(file)
        results[status] += 1
        
        # Print status with appropriate icon
        if status == 'success':
            print(f"    ✓ {message}")
        elif status == 'skipped':
            print(f"    ⊘ {message}")
        else:
            print(f"    ✗ Error: {message}")
        
        print()
    
    # Print summary
    print_summary(results)
    
    if results['success'] > 0:
        print("✨ Conversion complete! Your screen files now use flutter_screenutil.\n")
    elif results['skipped'] == results['total']:
        print("ℹ️  All files already have screenutil attributes applied.\n")
    else:
        print("⚠️  Conversion completed with some issues. Check the output above.\n")

if __name__ == "__main__":
    main()