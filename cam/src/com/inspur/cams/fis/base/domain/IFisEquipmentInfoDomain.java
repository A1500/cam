package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisEquipmentInfo;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisEquipmentInfoDomain
 * @Description: TODO 殡葬业务设备表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisEquipmentInfoDomain {

	public DataSet query(ParameterSet pset);

	// 查询统计模块中，殡仪车辆、火化设备、冷藏柜等List页面信息查询公用方法
	public DataSet queryForEquipmentCount(ParameterSet pset);

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

	public DataSet queryForRefrigerated(ParameterSet pset);

	public DataSet queryForRefrigeratedService(ParameterSet pset);

	@Trans
	public void insert(FisEquipmentInfo fisEquipmentInfo);

	@Trans
	public void batchInsert(List<FisEquipmentInfo> list);

	@Trans
	public void update(FisEquipmentInfo fisEquipmentInfo);

	@Trans
	public void batchUpdate(List<FisEquipmentInfo> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisEquipmentInfo> list);

	public DataSet queryForExport(ParameterSet set);
}