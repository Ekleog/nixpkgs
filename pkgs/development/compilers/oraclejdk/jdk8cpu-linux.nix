import ./jdk-linux-base.nix {
  productVersion = "8";
  patchVersion = "202";
  downloadUrl = http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html;
  sha256.i686-linux = "f2dd10a94c6b05e8b475a3a45233150440c10f3020d44ad3c00d37de441ad7a6";
  sha256.x86_64-linux = "9a5c32411a6a06e22b69c495b7975034409fa1652d03aeb8eb5b6f59fd4594e0";
  sha256.armv7l-linux = "0195ca06218c4d38964faf796c793855d5041f9bfb71ddcfadb056dc0e955419";
  sha256.aarch64-linux = "31eed2bf84f5aa58d325be4bc388ab9f82a6f8d35b446530fe89097576b3698b";
  jceName = "jce_policy-8.zip";
  jceDownloadUrl = http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html;
  sha256JCE = "0n8b6b8qmwb14lllk2lk1q1ahd3za9fnjigz5xn65mpg48whl0pk";
}
