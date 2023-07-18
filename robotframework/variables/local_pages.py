import os


def get_variables(directory: str):
    """
    Get all file paths from directory in a dictionary:
    - key: screenshots
    - value: list of file paths in form 'file:///path/to/file'
    """
    pages = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            screen_path = os.path.join(root, file)
            pages.append(f"file://{screen_path}")

    return {"urls": pages}
