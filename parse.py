import xlrd
import csv

def csv_from_excel():

    wb = xlrd.open_workbook('data.xls')
    sh = wb.sheet_by_name('new')
    your_csv_file = open('data.csv', 'wb')
    wr = csv.writer(your_csv_file, quoting=csv.QUOTE_ALL)

    for rownum in range(sh.nrows):
        wr.writerow(sh.row_values(rownum))

    your_csv_file.close()

csv_from_excel()