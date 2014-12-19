package com.inspur.cams.fis.base.domain.support;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisEquipmentInfoDao;
import com.inspur.cams.fis.base.dao.IFisResourceInfoDao;
import com.inspur.cams.fis.base.data.FisEquipmentInfo;
import com.inspur.cams.fis.base.data.FisResourceInfo;
import com.inspur.cams.fis.base.domain.IFisEquipmentInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisEquipmentInfoDomain
 * @Description: TODO 殡葬业务设备表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentInfoDomain implements IFisEquipmentInfoDomain {

	@Reference
	private IFisEquipmentInfoDao fisEquipmentInfoDao;
	@Reference
	private IFisResourceInfoDao fisResourceInfoDao;

	public DataSet query(ParameterSet pset) {
		return fisEquipmentInfoDao.query(pset);
	}

	// 查询统计模块中，殡仪车辆、火化设备、冷藏柜等List页面信息查询公用方法
	public DataSet queryForEquipmentCount(ParameterSet pset) {
		return fisEquipmentInfoDao.queryForEquipmentCount(pset);
	}

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
	public DataSet queryForEmplacingService(ParameterSet pset) {
		return fisEquipmentInfoDao.queryForEmplacingService(pset);
	}

	public DataSet queryForRefrigerated(ParameterSet pset) {
		return fisEquipmentInfoDao.queryForRefrigerated(pset);
	}

	public DataSet queryForRefrigeratedService(ParameterSet pset) {
		return fisEquipmentInfoDao.queryForRefrigeratedService(pset);
	}

	public DataSet queryForExport(ParameterSet set) {
		return fisEquipmentInfoDao.queryForExport(set);
	}

	public void insert(FisEquipmentInfo bean) {
	}

	public void batchInsert(List<FisEquipmentInfo> list) {
	}

	public void update(FisEquipmentInfo bean) {
	}

	public void batchUpdate(List<FisEquipmentInfo> list) {
	}

	public void delete(String[] delIds) {
	}

	public void save(List<FisEquipmentInfo> list) {
	}
}