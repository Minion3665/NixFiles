# Modified from https://github.com/gytis-ivaskevicius/nixfiles/blob/5439c8f4d7ccaeed57150846b1ed8afa0b7063ed/overlays/default.nix, which is licensed under the MIT license
# Below is a copy of that license:
/*
MIT License

Copyright (c) 2021 Gytis Ivaskevicius

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
# Therefore, this file is also copyable under MIT as it represents a "substantial portion" of the original code

final: prev: {
  discord = final.makeDesktopItem {
    name = "Discord";
    desktopName = "Discord new";
    genericName = "All-in-one cross-platform voice and text chat for gamers";
    exec = "${final.chromium}/bin/chromium --app=\"https://discord.com/channels/@me\"";
    icon = "discord";
    type = "Application";
    categories = "Network;InstantMessaging;";
    terminal = "false";
    mimeType="x-scheme-handler/discord";
  };

  element-desktop = final.makeDesktopItem {
    name = "Element";
    desktopName = "Element";
    genericName = "Secure and independent communication, connected via Matrix";
    exec = "${final.chromium}/bin/chromium --app=\"https://app.element.io/#/home\"";
    icon = "element";
    type = "Application";
    categories = "Network;InstantMessaging;";
    terminal = "false";
  };
}
