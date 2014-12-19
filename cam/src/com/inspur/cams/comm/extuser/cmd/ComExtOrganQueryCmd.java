package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.domain.IComExtOrganDomain;

/**
 * 外部单位查询cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganQueryCmd extends BaseQueryCommand {
	
	// 外部单位domain
	private IComExtOrganDomain comExtOrganDomain = (IComExtOrganDomain) ScaComponentFactory.getService(IComExtOrganDomain.class, "comExtOrganDomain/comExtOrganDomain");
	
	/**
	 * 查询外部单位
	 * @return
	 */
	public DataSet execute() {
		DataSet ds=comExtOrganDomain.queryExtOrgan(getParameterSet());
		return ds;
	}
	
	/**
	 * 根据行政区划查询外部单位
	 * @return
	 */
	public DataSet queryOrgan() {
		ParameterSet ps = getParameterSet();
		String id = (String) ps.getParameter("id");
		System.out.println(id+"!!!!!!");
		ParameterSet search = new ParameterSet();
		search.setParameter("AREA_CODE@=", id);
		search.setParameter("IN_USE@=", "1");
		return comExtOrganDomain.queryExtOrgan(search);
	}
	
	
}
