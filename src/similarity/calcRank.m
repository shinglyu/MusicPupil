function rank = calcRank(queryScore, sampScore)
   rank = meldistance(queryScore, sampScore, 'contour', 'taxi', 10, true );
   assert(length(rank) > 0)
end
