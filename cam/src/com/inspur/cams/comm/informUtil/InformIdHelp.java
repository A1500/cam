package com.inspur.cams.comm.informUtil;

import java.text.SimpleDateFormat;

import org.loushang.persistent.id.UUIDHexGenerator;



public class InformIdHelp {


	public static SimpleDateFormat formatYear = new SimpleDateFormat("yyyy");

	public static SimpleDateFormat formatMillisecond = new SimpleDateFormat("yyyyMMddHHmmssSSS");

	public static SimpleDateFormat formatYYMMDD = new SimpleDateFormat("yyMMdd");

	public static SimpleDateFormat formatYearTwoMonth = new SimpleDateFormat("yyyyMM");

	public static String getUUID32() {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();

        return String.valueOf(uuidHexGenerator.generate());
	}


	public static String getUUID30() {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();
        String UUID32 = String.valueOf(uuidHexGenerator.generate());

        return UUID32.substring(2);
	}


	public static String getUUID18() {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();
        String UUID32 = String.valueOf(uuidHexGenerator.generate());

        return UUID32.substring(14);
	}


	public static String getUUID(int n) {
		UUIDHexGenerator uuidHexGenerator = new UUIDHexGenerator();
        String UUID32 = String.valueOf(uuidHexGenerator.generate());

        return UUID32.substring(32 - n);
	}


}
