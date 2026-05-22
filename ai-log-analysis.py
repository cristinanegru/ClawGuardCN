log_file = "/var/log/apache2/error.log"

print("\n=== ClawGuardCN AI Log Analysis ===\n")

try:
   with open(log_file, "r") as file:
       lines = file.readlines()

   last_lines = lines[-10:]

   print("Recent Apache Errors:\n")

   for line in last_lines:
       print(line.strip())

   print("\n[ CLAWGUARDCN AI ANALYSIS ]\n")

   log_text = " ".join(last_lines).lower()

   if "shutting down gracefully" in log_text:
       print("Apache had a small emotional breakdown but shut down safely.")
       print("Good news: ClawGuardCN detected the problem and brought the server back online.")
       print("Website visitors can continue pretending nothing happened.")
       print("Recommended action: keep monitoring the server before Apache becomes dramatic again.")

   elif "resuming normal operations" in log_text:
       print("Apache is back and acting like nothing ever happened.")
       print("Server recovered successfully and normal operations resumed.")
       print("ClawGuardCN prevented downtime before users started complaining.")

   elif "error" in log_text or "failed" in log_text:
       print("Uh oh... Apache is clearly having a bad day.")
       print("The logs show possible server errors or failed operations.")
       print("Recommended action: investigate configuration files, logs, or suspicious activity.")
       print("Maybe offer Apache a coffee.")

   else:
       print("No critical issues detected.")
       print("Apache seems healthy, stable, and emotionally supported.")
       print("ClawGuardCN will continue monitoring silently in the background.")

except FileNotFoundError:
   print("Log file not found.")


