package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisFuneralDeadInfoDao;
import com.inspur.cams.fis.base.data.FisFuneralDeadInfo;
import com.inspur.cams.fis.base.domain.IFisFuneralDeadInfoDomain;

/**
 * @Package com.inspur.cams.fis.base.domain.support.FisFuneralDeadInfoDomian
 * @Description: 数据上报，逝者信息
 * @author jiangzhaobao
 * @date 2012-4-5
 */
public class FisFuneralDeadInfoDomain implements IFisFuneralDeadInfoDomain {
	@Reference
	private IFisFuneralDeadInfoDao fisFuneralDeadInfoDao;

	public void delete(String[] delIds) {
		fisFuneralDeadInfoDao.batchDelete(delIds);
	}

	public void insert(FisFuneralDeadInfo bean) {
		fisFuneralDeadInfoDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		return fisFuneralDeadInfoDao.query(pset);
	}

	public void save(List<FisFuneralDeadInfo> list) {
		fisFuneralDeadInfoDao.save(list);
	}

	public void update(FisFuneralDeadInfo bean) {
		fisFuneralDeadInfoDao.update(bean);
	}

	/**
	 * @Title: queyDeadInfo
	 * @Description: 数据上报，逝者信息查询
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadInfo(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queyDeadInfo(pset);
	}

	/**
	 * @Title: queyDeadNumber
	 * @Description: 数据上报，逝者信息统计
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadNumber(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queyDeadNumber(pset);
	}

	/**
	 * @Title: queryByReductionDic
	 * @Description: TODO(优惠类型字典)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryByReductionDic(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryByReductionDic(pset);
	}

	/**
	 * @Description: 分所在地区统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeadInfoSumByArea(pset);
	}

	/**
	 * @Description: 获取所在地区统计火化信息
	 * @author xuexzh
	 */
	public DataSet queyCremationDeadInfoByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queyCremationDeadInfoByArea(pset);
	}

	/**
	 * @Description: 分馆统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeadInfoSumByUnit(pset);
	}

	/**
	 * @Description: 逝者按年龄段信息统计
	 * @author xuexzh
	 */
	public DataSet queryNumByAge(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryNumByAge(pset);
	}

	/**
	 * @Description: 分所在地区统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathCauseInfoSumByArea(pset);
	}

	/**
	 * @Description: 分所在地区统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathDiseaseInfoSumByArea(pset);
	}

	/**
	 * @Description: 分馆统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathCauseInfoSumByUnit(pset);
	}

	/**
	 * @Description: 分馆统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathDiseaseInfoSumByUnit(pset);
	}

	/**
	 * @Description: 分所在地区统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathReduInfoSumByArea(pset);
	}

	/**
	 * @Description: 分馆统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathReduInfoSumByUnit(pset);
	}

	/**
	 * @Description: 分馆统计逝者服务情况
	 * @author xuexzh
	 */
	public DataSet queryDeathServicesInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathServicesInfoSumByUnit(pset);
	}

	/**
	 * @Description: 分馆统计骨灰去向
	 * @author xuexzh
	 */
	public DataSet queryDeathAshesgoInfoSumByUnit(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeathAshesgoInfoSumByUnit(pset);
	}

	/**
	 * @Description: 殡仪馆火化量分地区统计数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoAreaSumByArea(ParameterSet pset) {
		return fisFuneralDeadInfoDao.queryDeadInfoAreaSumByArea(pset);
	}
}
