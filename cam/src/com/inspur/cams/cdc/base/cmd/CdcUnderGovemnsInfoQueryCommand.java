package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcUnderGovemnsInfoDomain;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;

/**
 * @title:CdcUnderGovemnsInfoQueryCommand
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
public class CdcUnderGovemnsInfoQueryCommand extends BaseQueryCommand{
	
	private ICdcUnderGovemnsInfoDomain cdcUnderGovemnsInfoDomain = ScaComponentFactory
	.getService(ICdcUnderGovemnsInfoDomain.class, "cdcUnderGovemnsInfoDomain/cdcUnderGovemnsInfoDomain");
	// 外部单位用户domain
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcUnderGovemnsInfoDomain.query(pset);
	}
	
	
	//查询下辖村社区信息
	public DataSet queryUnder(){
		ParameterSet pset = getParameterSet();
		return cdcUnderGovemnsInfoDomain.queryUnder(pset);
	}
	public DataSet getElection(){
		DataSet returnDataSet = new DataSet();
		String organId = (String) getParameter("organCode");
		ParameterSet search = new ParameterSet();
		search.setParameter("USER_ID@=", organId);
		DataSet tempDataSet = comExtUserDomain.queryExtUser(search);
		returnDataSet = tempDataSet;
		if(tempDataSet.getCount()>0){
			Record record = tempDataSet.getRecord(0);
			if("1".equals(record.get("ifVillage"))){
				search.clear();
				search.setParameter("COMMUNITY_BELONGS@=", organId);
				search.setSortField("USER_ID");
				returnDataSet = comExtUserDomain.queryExtUser(search); 
			}
		}
		returnDataSet.addField("ELECTION");
		Record record = null;
		for(int i = 0;i<returnDataSet.getCount();i++){
			record = returnDataSet.getRecord(i);
			String userId = (String) record.get("userId");
			record.set("ELECTION", getElections(userId));
		}
		return returnDataSet;
	}

	/**
	 * 获取某下辖村历史选举信息
	 * @param userId
	 * @return
	 */
	private String getElections(String userId) {
		return cdcUnderGovemnsInfoDomain.getSelections(userId);
	}
}
