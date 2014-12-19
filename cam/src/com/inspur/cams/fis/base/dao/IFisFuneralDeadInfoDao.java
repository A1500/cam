package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralDeadInfo;

/**
 * @Package com.inspur.cams.fis.base.dao.IFisFuneralDeadInfoDao
 * @Description: 数据上报，逝者信息接口
 * @author jiangzhaobao
 * @date 2012-4-5
 */
public interface IFisFuneralDeadInfoDao extends BaseCURD<FisFuneralDeadInfo> {
	public void save(List<FisFuneralDeadInfo> list);

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

	public DataSet queryDeadInfoSumByArea(ParameterSet pset);

	public DataSet queyCremationDeadInfoByArea(ParameterSet pset);

	public DataSet queryDeadInfoSumByUnit(ParameterSet pset);

	public DataSet queryNumByAge(ParameterSet pset);

	public DataSet queryDeathCauseInfoSumByArea(ParameterSet pset);

	public DataSet queryDeathDiseaseInfoSumByArea(ParameterSet pset);

	public DataSet queryDeathCauseInfoSumByUnit(ParameterSet pset);

	public DataSet queryDeathDiseaseInfoSumByUnit(ParameterSet pset);

	public DataSet queryDeathReduInfoSumByArea(ParameterSet pset);

	public DataSet queryDeathReduInfoSumByUnit(ParameterSet pset);

	public DataSet queryDeathServicesInfoSumByUnit(ParameterSet pset);

	public DataSet queryDeathAshesgoInfoSumByUnit(ParameterSet pset);

	public DataSet queryDeadInfoAreaSumByArea(ParameterSet pset);
}
