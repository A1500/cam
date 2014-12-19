package com.inspur.cams.fis.base.service;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.dao.jdbc.FisVersionDao;
import com.inspur.cams.fis.base.data.FisFuneralImportReturn;
import com.inspur.cams.fis.base.data.FisImportData;
import com.inspur.cams.fis.base.domain.IFisImportDataDomain;

public class FisFuneralImportService implements IFisFuneralImportService {
	private IFisImportDataDomain fisImportDataDomain = ScaComponentFactory.getService(IFisImportDataDomain.class, "fisImportDataDomain/fisImportDataDomain");

	public FisFuneralImportReturn ifConnect(String unitId, String clientTimes) {
		// System.out.println("测试已连通：" + unitId);
		FisFuneralImportReturn ffir = new FisFuneralImportReturn();
		ffir.setUnitId(unitId);
		ffir.setIfConnect(true);
		ffir.setServerTimes(DateUtil.getTime());
		ffir.setClientTimes(clientTimes);

		// 先获取馆的最后一次上报时间
		Map map = fisImportDataDomain.getLastUploadTime(unitId);
		String lastUpdateTimes = null;
		if (map.get("END_TIME") != null) {
			lastUpdateTimes = (String) map.get("END_TIME");
		}

		if (lastUpdateTimes == null) {
			ffir.setLastUpdateTimes(null);
			ffir.setStartTimes("0000-00-00 00:00:00");
			ffir.setEndTimes(clientTimes);
		} else {
			if (lastUpdateTimes.compareTo(clientTimes) > 0) {
				ffir.setLastUpdateTimes(lastUpdateTimes);
				ffir.setStartTimes(null);
				ffir.setEndTimes(null);
			} else {
				ffir.setLastUpdateTimes(lastUpdateTimes);
				ffir.setStartTimes(lastUpdateTimes);
				ffir.setEndTimes(clientTimes);
			}
		}

		return ffir;
	}

	public FisFuneralImportReturn saveInRecord(FisFuneralImportReturn ffir, byte[] importData) {
		// 先设置上报结果为‘未完成’
		ffir.setIfFinish(false);
		
		//获取子系统最新版本
		String currentVersion = "";
		try{
			currentVersion = new FisVersionDao().getVersion();
		}catch(Exception e) {
		}
		ffir.setVersion(currentVersion);
		
		try {
//			System.out.println("FIS数据上报：" + ffir.getUnitId() + " " + importData.length);
			// 收到byte[]，进行转码
			String sqls = new String(importData, "utf-8");

			// 分解sql语句，进行批量执行
			if (sqls.length() > 0 && (sqls.indexOf("INSERT INTO") != -1 || sqls.indexOf("UPDATE") != -1)) {
				String[] sqlArr = sqls.split(";");
				fisImportDataDomain.batchImport(sqlArr);
				ffir.setIfFinish(true); // 未报错，设置上报结果为‘已完成’
			} else if(sqls.trim().length() <= 0){
				ffir.setUploadResultDesc("无数据！");
			} else {
				ffir.setUploadResultDesc("格式错误！");
			}

			// 当上报结果为‘已完成’时，插入导入历史记录
			if (ffir.isIfFinish()) {
				// 封装导入历史记录
				FisImportData fisImportData = new FisImportData();
				fisImportData.setRecordId(IdHelp.getUUID32());
				fisImportData.setUploadTime(ffir.getServerTimes());
				fisImportData.setUploadPerson("0"); // 0为自动接收
				fisImportData.setUploadUnit(ffir.getUnitId()); // 需要单独写一个方法，获取单位编号(殡葬)
				fisImportData.setUploadFile("");
				Blob blob = new Blob();
				blob.setData(importData);
				fisImportData.setUploadContent(blob);
				fisImportData.setUploadDesc(ffir.getContentDesc());
				fisImportData.setIfFile("0"); // 0为vpn，1为文件
				fisImportData.setStartTime(ffir.getStartTimes());
				fisImportData.setEndTime(ffir.getEndTimes());
				fisImportData.setClientTime(ffir.getClientTimes());
				fisImportDataDomain.insert(fisImportData);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			ffir.setUploadResultDesc("转码错误！");
		} catch (Exception e) {
			e.printStackTrace();
			ffir.setUploadResultDesc("上报错误！");
		}
		return ffir;
	}
}
