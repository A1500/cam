package com.inspur.cams.fis.base.service;

import com.inspur.cams.fis.base.data.FisFuneralImportReturn;

public interface IFisFuneralImportService {
	// 测试是否连通
	public FisFuneralImportReturn ifConnect(String unitId, String clientTimes);

	// 开始上报数据
	public FisFuneralImportReturn saveInRecord(FisFuneralImportReturn ffir, byte[] importData);
}
