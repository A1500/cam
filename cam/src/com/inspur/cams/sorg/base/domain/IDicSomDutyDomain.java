package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.DicSomDuty;
/**
 * 社会组织职务domian接口
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
public interface IDicSomDutyDomain {
	
	/**
	 * 查询社会组织职务
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 保存社会组织职务
	 * @param list
	 */
	@Trans
	public void save(List<DicSomDuty> list);
	
}
