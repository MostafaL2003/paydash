import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';

class SpendingChart extends StatelessWidget {
  final List<Transaction> transactions;

  const SpendingChart({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final last7Days = List<DateTime>.generate(
      7,
      (i) => DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: 6 - i)),
    );

    // Sum of negative amounts (spending) for each of the last 7 days
    Map<DateTime, double> spendingPerDay = {
      for (final day in last7Days) day: 0.0,
    };

    for (final tx in transactions) {
      final txDate = DateTime(tx.date.year, tx.date.month, tx.date.day);
      if (spendingPerDay.containsKey(txDate) && tx.amount < 0) {
        spendingPerDay[txDate] = spendingPerDay[txDate]! + tx.amount.abs();
      }
    }

    final List<FlSpot> spots = [];
    for (int i = 0; i < last7Days.length; i++) {
      final date = last7Days[i];
      spots.add(FlSpot(i.toDouble(), spendingPerDay[date] ?? 0));
    }

    final primaryColor = Theme.of(context).primaryColor;
    final gradientColors = [primaryColor, primaryColor.withOpacity(0.0)];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  gridData: FlGridData(
                    show: false,
                    drawVerticalLine: false,
                    drawHorizontalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        interval: 1,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          int idx = value.toInt();
                          if (idx < 0 || idx >= last7Days.length)
                            return const SizedBox();
                          final day = last7Days[idx];
                          final dayLetter =
                              DateFormat.E().format(day)[0]; // M, T, W, etc
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              dayLetter,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color?.withOpacity(0.7),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: primaryColor,
                      barWidth: 3,
                      spots: spots,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final amount = spot.y;
                          final day = last7Days[spot.x.toInt()];
                          final label = DateFormat.E().format(day);
                          // FIX: Provide non-nullable TextStyle with null-aware fallback
                          return LineTooltipItem(
                            "$label\n${NumberFormat.simpleCurrency().format(amount)}",
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                ) ??
                                const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
