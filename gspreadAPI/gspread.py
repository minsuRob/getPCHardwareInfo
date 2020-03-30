import gspread
from oauth2client.service_account import ServiceAccountCredentials

def writeCell(name):
    scope = [
    'https://spreadsheets.google.com/feeds',
    'https://www.googleapis.com/auth/drive',
    ]
    json_file_name = 'get-teachers-pc-infomation-55508d1aa28f.json'
    credentials = ServiceAccountCredentials.from_json_keyfile_name(json_file_name, scope)
    gc = gspread.authorize(credentials)
    spreadsheet_url = 'https://docs.google.com/spreadsheets/d/1N8aoSuzKRwqr0TfV2hGXrYAPq2KTzHNsMGUP5CElN7Q/edit#gid=0'
    # 스프레스시트 문서 가져오기
    doc = gc.open_by_url(spreadsheet_url)
    # 시트 선택하기
    worksheet = doc.worksheet('Sheet1')
    cell = worksheet.find(name)
    print("Found something at R%sC%s" % (cell.row, cell.col))

    worksheet.update_acell('B' + str(cell.row), name + '예쁜데~')


def readCell():
    scope = [
    'https://spreadsheets.google.com/feeds',
    'https://www.googleapis.com/auth/drive',
    ]
    json_file_name = 'get-teachers-pc-infomation-55508d1aa28f.json'
    credentials = ServiceAccountCredentials.from_json_keyfile_name(json_file_name, scope)
    gc = gspread.authorize(credentials)
    spreadsheet_url = 'https://docs.google.com/spreadsheets/d/1N8aoSuzKRwqr0TfV2hGXrYAPq2KTzHNsMGUP5CElN7Q/edit#gid=0'
    # 스프레스시트 문서 가져오기
    doc = gc.open_by_url(spreadsheet_url)
    # 시트 선택하기
    worksheet = doc.worksheet('Sheet1')

    cell_data = worksheet.acell('A2').value
    print(cell_data)
    return cell_data
