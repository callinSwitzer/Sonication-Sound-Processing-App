# Select Buzzes with Shiny App
# show an example, but don't save the data
# Send to colleagues at U of A
# updated 22 July 2016
# Callin Switzer

# install.packages("seewave")
library(seewave)
library(tuneR)
#install.packages('shiny')
library(shiny)


setWavPlayer("afplay") # mac specific sound player

wl = 2048 # window length
setwd("/Users/callinswitzer/Desktop/BuzzTimeApp/") # set working directory

# function allows me to find the start and stop of buzzes
# also returns the highest peak frequency

buzzTimeFreq <- function(buzzAudioFile){
     buzzes <<- buzzAudioFile
     wave1 <<- readWave(buzzes, units = "seconds", from = 0)
     #summary(wave1)
     # convert to mono
     r <<- mono(wave1, "both")
     
     # get sampling rate
     f <<- wave1@samp.rate
     
     # get wave length
     waveLen <<- length(wave1@right) / f
     
     # may have to change this directory to your own needs
     (ret <- runApp("/Users/callinswitzer/Desktop/buzzTimeApp"))
     
     
     
     # plot spectrum
     spp <- spec(r, # wave object
                 f = f, # frequency
                 from = ret[[1]], to = ret[[2]],  # section of wave
                 wl = wl, # window length
                 wn = "hanning", # hanning window
                 PSD = TRUE, # power spectral density
                 flim = c(.195, .6)) # frequency limits in kHz
     
     # filter to less than 600 Hz and greater than 195Hz
     sppFilt <- spp[spp[,1] < 0.6 & spp[,1] > .195,] 
     
     # identify peaks in this spectrum
     peaks <- which(diff(sign(diff(sppFilt[,2])))==-2)+1
     sppPks <- sppFilt[peaks,]
     # show top 5 highest peaks
     (tp5 <- sppPks[order(sppPks[,2], decreasing = T)[1:5],])
     points(tp5, col = 'red')
     text(tp5, labels = round(tp5[,1], digits = 3), adj = -.3)
     
     # listen to the sine waves at those frequencies for comparison
     listen(r, f = f, from = ret[[1]], to = ret[[2]] )
     pkNum <- 1
     listen(sine(tp5[pkNum,1]*1000, duration = 10000))
     sef <- c(ret[[1]], ret[[2]], tp5[pkNum,1]*1000)
     names(sef) <- NULL
     
     
     # write to a file
     # column names are as follows
     # filename, selected start (sec), selected end (sec), frequency (hz)
     fileConn <- "/Users/callinswitzer/Desktop/BuzzTimeApp/BuzzT2.txt"
     sink(fileConn, append = TRUE)
     cat("\n", buzzes, sef, "\n")
     sink() 
     
     # return values
     return(sef)
}

## Bumblebee example (loud buzzes)
buzzTimeFreq(buzzAudioFile = "DR-100_4104.wav")

## doesn't work that well with Anthophora buzzes -- spectrum is messy
## works well with wingbeat frequency
buzzTimeFreq("Anthophora5_Senna_3-22-2014.wav")


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
#                                  END                                      #
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##





