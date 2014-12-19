package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.domain.IComExtOrganTypeDomain;

/**
 * 外部单位类型查询cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganTypeQueryCmd extends BaseQueryCommand {
	
	// 外部单位类型domain
	private IComExtOrganTypeDomain comExtOrganTypeDomain = (IComExtOrganTypeDomain) ScaComponentFactory.getService(IComExtOrganTypeDomain.class, "comExtOrganTypeDomain/comExtOrganTypeDomain");
	
	/**
	 * 查询外部单位类型
	 * @return
	 */
	public DataSet execute() {
		return comExtOrganTypeDomain.queryExtOrganType(getParameterSet());
	}
	
}
