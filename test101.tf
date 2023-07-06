# Specify the resource type, and then the name
resource "proxmox_vm_qemu" "test101" {

  name = "test101" # Name to call the VM
  desc = "test101" # Description for the VM
  vmid = "244" # id of the virtual machine

  target_node = var.proxmox_host # Proxmox target node

  clone = var.template_name  # The name of the template that this resource will be created from

  agent = 1 # is the qemu agent installed?

  os_type = "cloud-init" # The OS type of the image clone
  cores = 2 
  sockets = 1 # number of CPU sockets
  cpu = "host" # The CPU type
  memory = 4096 # Amount of memory to allocate
  onboot = true # start the VM on host startup
  scsihw = "virtio-scsi-pci" # Scsi hardware type
  bootdisk = "scsi0" # The boot disk scsi

  # This section contains the disk configuration, it can be duplicated for additional disks
  #disk {
  #  size = "30G"
  #  type = "scsi"
  #  storage = "big"
  #  iothread = 0
  #}

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model = "virtio"
    bridge = "vmbr0"
  # tag = 20
  }

  #ipconfig0 = "ip=192.168.1.64/20,gw=192.168.1.1"
  #nameserver = "192.168.1.211"

  #serial {
  #  id = 0
  #  type = "socket"
  #}
  
  # sshkeys set using variables.
  #sshkeys = <<EOF
  #${var.ssh_key}
  #EOF

  # Terraform has provisioners that allow the execution of commands / scripts on a local or remote machine.
  # Here I execute a command to update the VM.
#  provisioner "remote-exec" {
#    inline = ["sudo apt update", "sudo apt upgrade -y", "echo Done!"]
#
#    connection {
#      host        = "172.16.20.43"
#      type        = "ssh"
#      user        = "ubuntu"
#      private_key = file(var.private_key_path)
#    }
#  }
}

#resource "null_resource" "bastion-ansible" {
#  provisioner "local-exec" {
#    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ansible_user}  -l bastion -i ../home-deploy/inventory --private-key ${var.private_key_path} -e 'pub_key=${var.public_key_path}' --ssh-extra-args '-o UserKnownHostsFile=/dev/null' ../home-deploy/main.yml"
#  }
#  depends_on = [ proxmox_vm_qemu.bastion ]
#}
