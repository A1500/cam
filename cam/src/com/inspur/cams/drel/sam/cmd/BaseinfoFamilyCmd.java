package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
/**
 * @title:家庭信息Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class BaseinfoFamilyCmd extends BaseAjaxCommand{
	private IBaseinfoDomain baseinfoDomain = ScaComponentFactory.getService(IBaseinfoDomain.class, "baseinfoDomain/baseinfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		BaseinfoFamily dataBean=(BaseinfoFamily)record.toBean(BaseinfoFamily.class);
		baseinfoDomain.insertFamily(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BaseinfoFamily dataBean=(BaseinfoFamily)record.toBean(BaseinfoFamily.class);
		baseinfoDomain.updateFamily(dataBean);
	}
}
