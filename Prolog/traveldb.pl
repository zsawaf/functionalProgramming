highway(F, HName, To, Price, Duration):- hw(F, HName, To, Price, Duration); hw(To, HName, F, Price, Duration).
hw(toronto, mountapu, london, 50, 420).
hw(toronto, mountmayon, london, 65, 360).
hw(toronto, mountapu, kingston, 90, 500).
hw(toronto, mountmayon, kingston, 95, 480).
hw(toronto, mounttimah, kingston, 80, 540).
hw(london, mounttimah, ottawa, 75, 80).
hw(ottawa, mountapu, kingston, 10, 60).
hw(ottawa, mounttimah, kingston, 12, 50).
hw(ottawa, mounttimah, kitchner, 11, 60).
hw(kingston, mounttimah, kitchner, 4, 80).
hw(kingston, mounttimah, windsor, 5, 60).
hw(windsor, mounttimah, kitchner, 8, 120).
hw(timmins, mountmayon, kenora, 5, 120).

city(toronto, 50, 60).
city(london, 75, 80).
city(kingston, 75, 45).
city(ottawa, 40, 30).
city(kitchner, 40, 20).
city(windsor, 50, 30).
city(timmins, 50, 10).
city(kenora, 40, 5).
