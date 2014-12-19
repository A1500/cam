package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisFuneralDeadInfo;

/**
 * @Package com.inspur.cams.fis.base.domain.IFisFuneralDeadInfoDomain
 * @Description: 数据上报，逝者信息
 * @author jiangzhaobao
 * @date 2012-4-5
 */

public interface IFisFuneralDeadInfoDomain {
	public DataSet query(ParameterSet pset);

	@Trans
	public void save(List<FisFuneralDeadInfo> list);

	@Trans
	public void insert(FisFuneralDeadInfo bean);

	@Trans
	public void update(FisFuneralDeadInfo bean);

	@Trans
	public void delete(String[] delIds);

	/**
	 * @Title: queyDeadInfo
	 * @Description: 数据上报，逝者信息查询
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadInfo(ParameterSet pset);

	/**
	 * @Title: queyDeadNumber
	 * @Description: 数据上报，逝者信息统计
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadNumber(ParameterSet pset);

	/**
	 * @Title: queryByReductionDic
	 * @Description: TODO(优惠类型字典)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryByReductionDic(ParameterSet pset);

	/**
	 * @Description: 分所在地区统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByArea(ParameterSet pset);

	/**
	 * @Description: 分馆统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 获取所在地区统计火化信息
	 * @author xuexzh
	 */
	public DataSet queyCremationDeadInfoByArea(ParameterSet pset);

	public DataSet queryNumByAge(ParameterSet pset);

	/**
	 * @Description: 分所在地区统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByArea(ParameterSet pset);

	/**
	 * @Description: 分所在地区病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByArea(ParameterSet pset);

	/**
	 * @Description: 分馆统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 分馆统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 分所在地区统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByArea(ParameterSet pset);

	/**
	 * @Description: 分馆统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 分馆统计逝者服务情况
	 * @author xuexzh
	 */
	public DataSet queryDeathServicesInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 分馆统计骨灰去向
	 * @author xuexzh
	 */
	public DataSet queryDeathAshesgoInfoSumByUnit(ParameterSet pset);

	/**
	 * @Description: 殡仪馆火化量分地区统计数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoAreaSumByArea(ParameterSet pset);

}
