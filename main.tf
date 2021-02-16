resource "google_os_login_ssh_public_key" "mykey" {
    user = "terraform-gcp-sa@terragcp-web.iam.gserviceaccount.com"
    key = file("/root/.ssh/id_rsa.pub")
}

resource "google_compute_instance" "web" {
  name         = "web-app"
  machine_type = "f1-micro"

  metadata = {
  
    enable-oslogin = "TRUE"
    metadata_startup_script = file("provisioner/apache2.sh")

  }  


  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
    
  }


  

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  network_interface {
    network = google_compute_network.vpc.name
    access_config {

    }


  }
}


output "ip" {
  value = google_compute_instance.web.network_interface.0.access_config.0.nat_ip
}