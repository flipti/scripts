Add-Type -AssemblyName System.Speech

$soundFilePath = "c:\temp\audio.wav"

# Save the Audio to a file
[System.Speech.Synthesis.SpeechSynthesizer] $voice = $null
Try {
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.SetOutputToWaveFile($soundFilePath)

    $voice.Speak("se a maquina virtual desligou, a culpa é da equipe de backup")
    $voice.SelectVoice("Microsoft Zira Desktop")
    
} Finally {
    # Make sure the wave file is closed
    if ($voice) {
        $voice.Dispose()
    }
}
