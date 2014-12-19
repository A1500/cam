package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.extuser.data.ComExtOrganType;
import com.inspur.cams.comm.extuser.domain.IComExtOrganTypeDomain;

/**
 * 外部单位类型cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganTypeCmd extends BaseAjaxCommand {

	// 外部单位类型domain
	private IComExtOrganTypeDomain comExtOrganTypeDomain = (IComExtOrganTypeDomain) ScaComponentFactory.getService(IComExtOrganTypeDomain.class, "comExtOrganTypeDomain/comExtOrganTypeDomain");
	
	/**
	 * 增加外部单位类型
	 */
	public void insert() {
		Record record = (Record) getParameter("comExtOrganType");
		ComExtOrganType comExtOrganType = (ComExtOrganType) record.toBean(ComExtOrganType.class);
		comExtOrganTypeDomain.insertComExtOrganType(comExtOrganType);
	}
	
	/**
	 * 修改外部单位类型
	 */
	public void update() {
		Record record = (Record) getParameter("comExtOrganType");
		ComExtOrganType comExtOrganType = (ComExtOrganType) record.toBean(ComExtOrganType.class);
		comExtOrganTypeDomain.updateComExtOrganType(comExtOrganType);
	}

	/**
	 * 删除外部单位类型
	 */
	public void delete() {
		String code = (String) getParameter("code");
		comExtOrganTypeDomain.deleteComExtOrganType(code);
	}
	
}
