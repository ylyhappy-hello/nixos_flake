
(final: prev: {
  jetbrains-idea-ultimate-d = prev.jetbrains.idea-ultimate.overrideAttrs (finalAttrs: {
    version = "2022.3.3";
    src = finalAttrs.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "";
    };  
    vmoptsFile = ''sss'';
    installPhase = finalAttrs.installPhase + ''
    echo '
-javaagent:${(final.callPackage ./jetbrains-agent.nix { })}/ja-netfilter/ja-netfilter.jar
                            '>> $out/idea-ultimate/bin/idea64.vmoptions
    '';
  });
})

# --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
# --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED

