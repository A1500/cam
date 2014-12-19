package com.inspur.cams.drel.organ.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.organ.date.SamSupportOrgan;

/**
 * @title:SamSupportOrgan
 * @description:孤儿院、敬老院 Domain接口
 * @author douyn
 * @since:2012-05-21
 * @version:1.0
*/
public interface ISamSupportOrganDomain {

	/**
	 * 一般查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 添加新记录到数据库
	 * @param organ
	 */
	@Trans
	public void insert(SamSupportOrgan organ);
	/**
	 * 更新数据库中已有的一条记录
	 * @param organ
	 */
	@Trans
	public void update(SamSupportOrgan organ);
	/**
	 * 删除数据库中已有的一条记录
	 * @param organ
	 */
	@Trans
	public void delete(String organId);

}
