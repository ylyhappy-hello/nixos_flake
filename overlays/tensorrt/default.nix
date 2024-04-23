let 
  version = "3.2.3-20201";
  _hash = "9681283b";
in
(final: prev: {
  tensorrt = prev.cudaPackages.tensorrt.overrideAttrs (finalAttrs: {
    src = ./TensorRT-8.5.3.1.Linux.x86_64-gnu.cuda-11.8.cudnn8.6.tar.gz;
  });
})

# --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
# --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED


