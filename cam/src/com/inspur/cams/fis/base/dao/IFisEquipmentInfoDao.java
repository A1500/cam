package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisEquipmentInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisEquipmentInfoDao
 * @Description: TODO 殡葬业务设备表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisEquipmentInfoDao extends BaseCURD<FisEquipmentInfo> {
	public void save(List<FisEquipmentInfo> list);

	public DataSet queryForRefrigerated(ParameterSet pset);

	public DataSet queryForRefrigeratedService(ParameterSet pset);

	/**
	 * 
	 * @Title: queryForEmplacingService
	 * @Description: TODO(寄存设备和墓穴使用记录查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author luguosui
	 * @date 2011-12-14
	 */
	public DataSet queryForEmplacingService(ParameterSet pset);

	// 查询统计模块中，殡仪车辆、火化设备、冷藏柜等List页面信息查询公用方法
	public DataSet queryForEquipmentCount(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}