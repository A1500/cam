package com.inspur.cams.drel.special.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.special.data.SpecialpoorFamily;

/**
 * @title:ISpecFamilyDomain
 * @description:
 */
public interface ISpecFamilyDomain {
	public DataSet query(ParameterSet pset);

	/**
	 * @Description: 特殊困难户分致贫原因统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByType(ParameterSet pset);

	/**
	 * @Description: 特殊困难户分地区统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByArea(ParameterSet pset);
	/**
	 * 保存
	 * @param specialpoorFamily
	 */
	@Trans
	public String saveFamily(SpecialpoorFamily specialpoorFamily);
	/**
	 * 删除一条家庭信息
	 * @param familyId
	 */
	@Trans
	public void deleteFamily(String familyId);
	/**
	 * 根据帮包村代码获取帮扶单位
	 */
	public String getSupportName(String helpVillageCode);
	/**
	 * @Description: 特殊困难户省直单位统计
	 * @author yll
	 */
	public DataSet queryBySupport(ParameterSet pset);
}
