from selenium import webdriver
from selenium.webdriver.edge.service import Service
from webdriver_manager.microsoft import EdgeChromiumDriverManager

options = webdriver.EdgeOptions()
options.add_argument("--headless")  # Execute o Edge em modo headless
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

# Configure o serviço para Edge WebDriver
service = Service(EdgeChromiumDriverManager().install())
driver = webdriver.Edge(service=service, options=options)

# Teste básico para abrir uma página e verificar o título
driver.get("http://www.google.com")
print(driver.title)

driver.quit()
