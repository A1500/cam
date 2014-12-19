package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisFuneralDeadInfoDomain;

/**
 * @Package com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd
 * @Description: TODO
 * @author jiangzhaobao
 * @date 2012-4-5
 */
public class FisFuneralDeadInfoQueryCmd extends BaseQueryCommand {
	IFisFuneralDeadInfoDomain service = ScaComponentFactory.getService(IFisFuneralDeadInfoDomain.class, "FisFuneralDeadInfoDomain/FisFuneralDeadInfoDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	/**
	 * @Title: queyDeadInfo
	 * @Description: 数据上报，逝者信息查询
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadInfo() {
		ParameterSet pset = getParameterSet();
		return service.queyDeadInfo(pset);
	}

	/**
	 * @Title: queyDeadNumber
	 * @Description: 数据上报，逝者信息统计
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queyDeadNumber() {
		ParameterSet pset = getParameterSet();
		return service.queyDeadNumber(pset);
	}

	/**
	 * @Title: queryByReductionDic
	 * @Description: TODO(优惠类型字典)
	 * @return DataSet
	 * @throws
	 * @author jiangzhaobao
	 */
	public DataSet queryByReductionDic() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryByReductionDic(pset);
		return ds;
	}

	/**
	 * @Description: 分所在地区统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeadInfoSumByArea(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计火化数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeadInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 殡仪馆火化量分地区统计数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoAreaSumByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeadInfoAreaSumByArea(pset);
		return ds;
	}
	
	/**
	 * @Description: 分所在地区统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathCauseInfoSumByArea(pset);
		return ds;
	}

	/**
	 * @Description: 分所在地区统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathDiseaseInfoSumByArea(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathCauseInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathDiseaseInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 分所在地区统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathReduInfoSumByArea(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathReduInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计逝者服务情况
	 * @author xuexzh
	 */
	public DataSet queryDeathServicesInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathServicesInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 分馆统计骨灰去向
	 * @author xuexzh
	 */
	public DataSet queryDeathAshesgoInfoSumByUnit() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryDeathAshesgoInfoSumByUnit(pset);
		return ds;
	}

	/**
	 * @Description: 获取所在地区统计火化信息
	 * @author xuexzh
	 */
	public DataSet queyCremationDeadInfoByArea() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queyCremationDeadInfoByArea(pset);
		return ds;
	}

	/**
	 * @Description: 逝者按年龄段信息统计
	 * @author xuexzh
	 */
	public DataSet queryNumByAge() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryNumByAge(pset);
		return ds;
	}
}
