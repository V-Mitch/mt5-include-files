//+------------------------------------------------------------------+
//|                                                 TrailingStop.mqh |
//|                                                           Victor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Victor"
#property link      "https://www.mql5.com"
#include<Trade\Trade.mqh>
//#include "Trade.mqh"

CTrade trade;

class CTrailing
{
	protected:
		MqlTradeRequest request;
		
	public:
		MqlTradeResult result;
		
		void CheckTrailingStop(double Ask, double Bid, double Stop);
		
//		bool TrailingStop(string pSymbol, int pTrailPoints, int pMinProfit = 0, int pStep = 10);

};


void CTrailing::CheckTrailingStop(double Ask, double Bid, double Stop)
   {
   // Stop loss for a buy position
   if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
      {
   // Stop Loss
      double TrailStopPrice = NormalizeDouble(Ask * (1 - Stop * 0.01), _Digits);  
      // In case there are multiple positions. For each position in descending order:
      for(int i = PositionsTotal()-1; i>=0; i--)
            {
            string symbol = PositionGetSymbol(i);
            if(_Symbol==symbol)
               {
               ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
               double CurrentSL = PositionGetDouble(POSITION_SL);
               // When the new trail stop is larger than the current one, it needs to be updated.
               if(CurrentSL < TrailStopPrice)
                  {
                  trade.PositionModify(PositionTicket, (CurrentSL * 1.001 ),0);
                  }
               }
            }
       }
    // Stop loss for a buy position
    if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
      {
   // Stop Loss
      double TrailStopPrice = NormalizeDouble(Bid * (Stop * 0.01 + 1), _Digits);  
      // In case there are multiple positions. For each position in descending order:
      for(int i = PositionsTotal()-1; i>=0; i--)
            {
            string symbol = PositionGetSymbol(i);
            if(_Symbol==symbol)
               {
               ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
               double CurrentSL = PositionGetDouble(POSITION_SL);
               // When the new trail stop is larger than the current one, it needs to be updated.
               if(CurrentSL > TrailStopPrice)
                  {
                  trade.PositionModify(PositionTicket, (CurrentSL * 0.999 ),0);
                  }
               }
            }
       }
   }
