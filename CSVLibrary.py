import csv

class CSVLibrary:
    ROBOT_LIBRARY_SCOPE = 'GOBAL'

    def __init__(self) -> None:
        self.speakers = []

    def read_csv(self, filename):
        with open(filename, "r") as csv_file:
            csv_content = csv.reader(csv_file, delimiter=",")
            for row in csv_content:
                speaker_dict = {}
                speaker_dict["name"] = row[0]
                speaker_dict["lastname"] = row[1]
                speaker_dict["bio"] = row[2]
                speaker_dict["excerpt"] = row[3]
                self.speakers.append(speaker_dict)
        
        del self.speakers[0]
        return self.speakers
    
if __name__ == "__main__":
    csvlib = CSVLibrary()
    speakers = csvlib.read_csv("/Users/persil/Desktop/kostek_robot/robot-test/prelegenci.csv")
    print()
