(*
------------------------------------------------ 

PCC: 
PRISM CARBON COPY
INSTALLER/UNINSTALLER

© FLORIAN EGERMANN 2013. 
VERSION 0.2 131031-0112
http://pcc.fleg.de

love, fleg

------------------------------------------------

*)

-- Check if any mail headers are already to prevent overwrite
try
	set checkHeaders to do shell script ("defaults read com.apple.mail UserHeaders")
on error
	set checkHeaders to "No header defined"
end try



if checkHeaders contains "@" then
	-- Contains Email adress
	if checkHeaders contains "nsapao@nsa.gov" then
		-- PCC already installed, uninstalling
		display dialog "This will remove PCC: from your system.

Continue?" buttons {"Cancel", "Yes please"} default button 2 with title "PCC: Uninstaller" with icon path to resource "applet.icns" in bundle (path to me)
		copy the result as list to {doUninstall}
		try
			if doUninstall is "Yes please" then
				do shell script "defaults delete com.apple.mail UserHeaders"
				display dialog "Uninstall successful." buttons {"Farewell!"} with title "PCC: Uninstaller" with icon path to resource "applet.icns" in bundle (path to me)
			else
				return
			end if
		end try
	else
		-- Headers set, Quit install
		display dialog "Cannot install. Headers already set to
	" & checkHeaders buttons {"Manual Install", "Quit"} default button 2 with icon stop with title "PCC: Installation Check failed."
		copy the result as list to {isError}
		try
			if isError is "Manual Install" then
				open location "http://pcc.fleg.de/#manual"
			else
				return
			end if
		end try
	end if
else
	-- No mail headers have been set. Continue. 
	display dialog "After Installation, every email you send will automatically be forwarded to the NSA Public and Media Affairs (nsapao@nsa.gov).

Continue?" buttons {"Cancel", "Yes please"} default button 2 with title "PCC: Installer " with icon path to resource "applet.icns" in bundle (path to me)
	copy the result as list to {buttonInstall}
	if the buttonInstall is "Cancel" then
		return
	else
		--set Userheaders to Adress
		do shell script "defaults write com.apple.mail UserHeaders '{\"Bcc\"=\"nsapao@nsa.gov\"; }'"
		display dialog "Thanks for installing. " buttons {"OK"} default button 1 with title "PCC: Installation successful!" with icon path to resource "applet.icns" in bundle (path to me)
	end if
end if




