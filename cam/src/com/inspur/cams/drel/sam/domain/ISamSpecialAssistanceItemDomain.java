package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem;


/**
 * @title:ISamSpecialAssistanceItemDomain
 * @description:
 * @author douyn
 * @since:2012-05-17
 * @version:1.0
*/
public interface ISamSpecialAssistanceItemDomain{

	/**
	 * 查询数据
	 * @param pset
	 * @return 
	 */
	DataSet query(ParameterSet pset);

	/**
	 * 通过主键Id查询数据
	 * @param id
	 * @return
	 */
	DataSet queryById(String id);

	/**
	 * 保存新增专项救助项目
	 * @param item
	 */
	@Trans
	public void save(SamSpecialAssistanceItem item);

	/**
	 * 更新数据库中以保存专项救助项目信息
	 * @param item
	 */
	void update(SamSpecialAssistanceItem item);

}
