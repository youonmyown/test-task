import subprocess

def get_elastic_ip():
    result = subprocess.run(['terraform', 'output', '-raw', 'elastic_ip'], capture_output=True, text=True)
    result.check_returncode()
    return result.stdout.strip()

def write_hosts_file(elastic_ip):
    with open('hosts', 'w') as f:
        f.write('[webserver]\n')
        f.write(f'{elastic_ip} ansible_python_interpreter=/usr/bin/python3\n')

if __name__ == "__main__":
    elastic_ip = get_elastic_ip()
    write_hosts_file(elastic_ip)
