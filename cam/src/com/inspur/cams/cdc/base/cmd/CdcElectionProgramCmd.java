package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionProgram;
import com.inspur.cams.cdc.base.domain.ICdcElectionProgramDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 民主选举选举程序信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionProgramCmd extends BaseAjaxCommand {

	private ICdcElectionProgramDomain cdcElectionProgramDomain = ScaComponentFactory
			.getService(ICdcElectionProgramDomain.class, "cdcElectionProgramDomain/cdcElectionProgramDomain");
	
	// 增加
	public void save() {
		Record record = (Record) getParameter("record");
		CdcElectionProgram cdcElectionProgram = (CdcElectionProgram) record.toBean(CdcElectionProgram.class);
		if(cdcElectionProgram.getProgramId()==null||"".equals(cdcElectionProgram.getProgramId())){
			cdcElectionProgram.setProgramId(cdcElectionProgram.getOrganCode()+IdHelp.getUUID32());
			cdcElectionProgram.setStatus("0");
			cdcElectionProgram.setCreateTime(DateUtil.getTime());
			cdcElectionProgramDomain.insert(cdcElectionProgram);
		}else if(cdcElectionProgram.getState()==Record.STATE_MODIFIED){
			cdcElectionProgramDomain.update(cdcElectionProgram);
		}
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionProgram cdcElectionProgram = (CdcElectionProgram) record.toBean(CdcElectionProgram.class);
		cdcElectionProgramDomain.update(cdcElectionProgram);
	}
	
}