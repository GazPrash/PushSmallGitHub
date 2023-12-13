# PushSmall - Automate Gitignore for your repos!

## Overview

This simple Bash shell script automates the process of adding files larger than a specified size to your `.gitignore` file. By doing so, these large files will be excluded from your commits to GitHub, helping to manage your repository size and hence allowing you to 

## How It Works

The script scans the current directory for files exceeding a specified size threshold and automatically appends their names to the `.gitignore` file.

### Prerequisites

Make sure you have Bash installed on your system.

### Usage
PushSmall can be used for automating the process of creating .gitignore files, on execution this script will automatically create a `.gitignore` file in your project's base directory and add files that are larger than the specified file size limit so that you do not accidently commit them in your branch.

1. Clone the repository:

   ```bash
   git clone https://github.com/GazPrash/PushSmallGitHub.git
   ```
2. Run `push_small.sh` with the following arguments:
   ```bash
      ./push_small.sh <base_directory> <size_limit>
   ```
   *Use the abstract path in `base_directory` if you are not running the script from the base directory, if you are just use the relative path.*

3. A `.gitignore` file must have been created at the `<base_directory>`.