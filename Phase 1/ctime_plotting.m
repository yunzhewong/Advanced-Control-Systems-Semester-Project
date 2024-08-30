close all

createSystemSpecFigure()
plot(out.ctime.Time, out.ctime.Data, "r-", "DisplayName", "Plant Response")
title("Continuous-Time Controlled Plant Response")
