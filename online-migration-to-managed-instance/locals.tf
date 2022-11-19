locals {
  suffix = random_id.this.hex
}

resource "random_id" "this" {
  byte_length = 4
}
