package com.inspur.cams.comm.brief.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.data.CamsBriefConfig;
import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.domain.ICamsBriefConfigDomain;
import com.inspur.cams.comm.util.IdHelp;


/**
 * 快报简报配置表cmd
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefConfigCmd extends BaseAjaxCommand {

	private ICamsBriefConfigDomain camsBriefConfigDomain = ScaComponentFactory
			.getService(ICamsBriefConfigDomain.class, "camsBriefConfigDomain/camsBriefConfigDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CamsBriefConfig camsBriefConfig = (CamsBriefConfig) record.toBean(CamsBriefConfig.class);
		camsBriefConfigDomain.insert(camsBriefConfig);
		
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CamsBriefConfig camsBriefConfig = (CamsBriefConfig) record.toBean(CamsBriefConfig.class);
		camsBriefConfigDomain.update(camsBriefConfig);
	}
	
	// 删除
	public void delete() {
		String configId = (String) getParameter("configId");
		camsBriefConfigDomain.delete(configId);
	}
	
}