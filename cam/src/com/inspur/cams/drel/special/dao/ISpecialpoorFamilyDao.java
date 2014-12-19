package com.inspur.cams.drel.special.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.special.data.SpecialpoorFamily;

/**
 * @title:ISpecialpoorFamilyDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
 */
public interface ISpecialpoorFamilyDao extends BaseCURD<SpecialpoorFamily> {
	public void save(List<SpecialpoorFamily> list);

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
	 * 删除一条家庭信息
	 * @param familyId
	 */
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
