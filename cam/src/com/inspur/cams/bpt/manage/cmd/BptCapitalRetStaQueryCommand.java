package com.inspur.cams.bpt.manage.cmd;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.capital.domain.IBptCapitalRetStaDomain;

/**
 * 农村退役士兵补助标准查询
 * @author  Lin Yangyang
 *
 */
public class BptCapitalRetStaQueryCommand extends BaseQueryCommand{
	private IBptCapitalRetStaDomain service = ScaComponentFactory.getService(IBptCapitalRetStaDomain.class,"retStaDomain/retStaDomain");
	/**
	 * 查询功能
	 * @return
	 */
	public DataSet query(){
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	/**
	 * execute默认方法
	 * @return
	 */
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}