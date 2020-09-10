//+------------------------------------------------------------------+
//|                                            NewCandlePresence.mqh |
//|                                                           Victor |
//|                                       https://github.com/V-Mitch |
//+------------------------------------------------------------------+
#property copyright "Victor"
#property link      "https://github.com/V-Mitch"


// Class declaration
class CCandle
{
   public:
      bool CheckForNewCandle();

};


bool CCandle::CheckForNewCandle()
   {
   
   // Total number of candles on the chart
   int CandleNumber = Bars(_Symbol,_Period);
   
   // Static variable will stay the same when function is re-run. 
   static int LastCandleNumber;
 
   bool IsNewCandle = 0;
   
   if (CandleNumber > LastCandleNumber)
      {
      IsNewCandle = 1;
      LastCandleNumber = CandleNumber;
      }
   //Print("New Candle: ", IsNewCandle);   
   return IsNewCandle;
   
   }