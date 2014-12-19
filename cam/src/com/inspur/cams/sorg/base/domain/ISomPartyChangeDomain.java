package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPartyChange;
/**
 * 
 * @title 社会组织党建变更domain接口
 *
 */
public interface ISomPartyChangeDomain {
	public DataSet query(ParameterSet pset);
	@Trans
	public void insert(SomPartyChange somPartyChange);
	
	@Trans
	public void update(SomPartyChange somPartyChange);
	
	@Trans
	public void delete(String changeId);
	@Trans
	public void uploadSave_change(SomPartyChange somPartyChange);
}
