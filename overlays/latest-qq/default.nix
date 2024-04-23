let 
  version = "3.2.3-20201";
  _hash = "9681283b";

in
(final: prev: {
  latest-qq = prev.qq.overrideAttrs (finalAttrs: {
    inherit version;
    src = final.fetchurl {
      url = "https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.7_240403_amd64_01.deb";
      hash = "sha256-7XdxkILIkWMBJLd/xz79SqytMJeDYbrhexHxv2C402U=";
    };
  });
})

# --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
# --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED


