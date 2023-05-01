{
  config.services.usbguard = {
    enable = true;
    presentControllerPolicy = "apply-policy";
    rules = ''
      allow id 13fe:6500 serial "07001A619AA30209" name "USB DISK 3.2" hash "FlEx/NqvcbbmeLX9nBH9jYlA5v4iNlVaDAbhuZiSVCU="
      # Allow our USB expansion card, which is essential for editing NixFiles

      allow id 1d6b:0002 serial "0000:00:0d.0" name "xHCI Host Controller" hash "d3YN7OD60Ggqc9hClW0/al6tlFEshidDnQKzZRRk410="
      allow id 1d6b:0002 serial "0000:00:14.0" name "xHCI Host Controller" hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o="
      allow id 1d6b:0003 serial "0000:00:0d.0" name "xHCI Host Controller" hash "4Q3Ski/Lqi8RbTFr10zFlIpagY9AKVMszyzBQJVKE+c="
      allow id 1d6b:0003 serial "0000:00:14.0" name "xHCI Host Controller" hash "prM+Jby/bFHCn2lNjQdAMbgc6tse3xVx+hZwjOPHSdQ="
      # Permit all of our USB controllers

      allow id 2109:2822 serial "000000001" name "USB2.0 Hub             " hash "nNtFngze2aK/lLwMEaNVxnZFHSGKRmUvOxKvWPaUBdY="
      allow id 2109:0822 serial "000000001" name "USB3.1 Hub             " hash "mUkwP3O/3LVSILcfnanU2c2/SYxR6Wlb9Y/4VhehANM="
      # ^ 7-port USB hub
      allow id 0424:5534 serial "" name "USB5534B" hash "lB2Y9gjh8npbRQ27rG3idTN6924ryDLRf63bPbeymUo="
      allow id 0424:2134 serial "" name "USB2134B" hash "1bfHz4/5nO4aYIwQG5Ci/F/9HBCKCPOdq/1eoUswB0M="
      # ^ Monitor USB hub
      # And our USB hubs

      allow id 27c6:609c serial "UID419B7B07_XXXX_MOC_B0" name "Goodix USB2.0 MISC" hash "KTVrE0NabTXPFvACpFvVsHWwQQ8jaytMoTziVo2lJu4="
      # Allow our fingerprint scanner

      allow id 8087:0032 hash "ClCa9utWpkfhSL14jLzpmilrrbre65+44YYBM4ysI/4=" with-connect-type "hardwired"
      # Allow our bluetooth controller

      allow with-interface equals { 08:*:* }
      # Allow pure USB storage

      reject with-interface all-of { 08:*:* 03:00:* }
      reject with-interface all-of { 08:*:* 03:01:* }
      reject with-interface all-of { 08:*:* e0:*:* }
      reject with-interface all-of { 08:*:* 02:*:* }
      # Reject (read: disconnect) USB storage that's also doing something other than storage

      allow id 045e:07b1 serial "" name "Microsoft\xc2\xae Nano Transceiver v1.0" hash "hTBZLj0mVeCFy8pvhS7WB0nD6j0u+U27JnigRrXcEZY="
      # Allow our Arc-touch mouse

      allow id 056a:0042 serial "" name "XD-0608-U" hash "PTutnro9J1p6I9GeNUIblNOtQrpVgWEWJs43aHoHUFI="
      allow id 256c:006d serial "" name "Gaomon Tablet" hash "nbuHDO++57blBwSpr8ZEiRRyFcs4dg4u2IkKjCSP+ho="
      # Allow our drawing tablets
    '';
  };
}
