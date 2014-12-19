package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmDic;
import com.inspur.cams.jcm.domain.IJcmDicDomain;

/**
 * 字典管理cmd
 * @author 
 * @date 2014-12-15
 */
public class JcmDicCmd extends BaseAjaxCommand {

	private IJcmDicDomain jcmDicDomain = ScaComponentFactory
			.getService(IJcmDicDomain.class, "jcmDicDomain/jcmDicDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmDic jcmDic = (JcmDic) record.toBean(JcmDic.class);
		jcmDicDomain.insert(jcmDic);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmDic jcmDic = (JcmDic) record.toBean(JcmDic.class);
		jcmDicDomain.update(jcmDic);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		jcmDicDomain.delete(id);
	}
	public void save(){
		List<JcmDic> equList = new ArrayList<JcmDic>();
		
		Record[] records = (Record[]) getParameter("records");
		if(records!=null){
			for(int i=0;i<records.length;i++){
				JcmDic jcmDic = (JcmDic) records[i].toBean(JcmDic.class);
				equList.add(jcmDic);
			}
		}
		jcmDicDomain.save(equList);
	}
}