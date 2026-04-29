# Graph Script

This script fetches and visualizes your sleep data over time. It pulls information about how many hours you slept each night and measures the quality of your sleep, then displays it as a chart that you can filter by different time periods (7, 30, or 90 days). The app calculates a risk score based on your sleep quality so you can easily see when your apnea risk might be higher.

## How the Risk Calculation Works

The script converts sleep quality (1.0-2.0) into a risk score (0-100) using this formula:

**Risk = (3 - Quality) × 50**

- **Quality 2.0** (best sleep) = Risk 50 (low risk)
- **Quality 1.8** = Risk 60 (medium risk)
- **Quality 1.0** (worst sleep) = Risk 100 (high risk)

Lower quality sleep means higher apnea risk.

---

**The script:** [../graph.html](../graph.html)
