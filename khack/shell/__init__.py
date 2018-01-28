from subprocess import call, check_output

def shell(command, shell=True):
    result = call(command, shell=shell)
    if result != 0:
        exit(result)

def shell_output(command, shell=True):
    result = check_output(command, shell=shell)
    if not result:
        exit(result)

    return result.strip()
