package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomMeetingDao;
import com.inspur.cams.sorg.base.data.SomMeeting;

/**
 * @title:SomMeetingDao
 * @description:
 * @author:
 * @since:2011-05-11
 * @version:1.0
*/
public class SomMeetingDao extends EntityDao<SomMeeting> implements ISomMeetingDao{
	public static String MEETING_REF_SQL = "SELECT * FROM SOM_SESSION S WHERE SEQ=(SELECT MAX(TO_NUMBER(SEQ))  FROM SOM_SESSION T WHERE T.SORG_ID=?) AND S.SORG_ID=?";
  	@Override
	public Class<SomMeeting> getEntityClass() {
  		return SomMeeting.class;
	}
  	
  	/**
	 * 通过会议关联章程、会费、负责人换届是否进行过，需要查询换届备案已经完成的
	 * @param pset
	 * @return
	 */
	public DataSet qurtyWithBeianInfo(ParameterSet pset) {
		String sorgId=(String)pset.getParameter("sorgId");
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT C.MEETING_ID    AS meetingId,  ");
		sql.append("        c.meeting_name  AS meetingName,  ");
		sql.append("        a.task_code     AS TASKCODE,  ");
		sql.append("        c.meeting_date  AS meetingDate,  ");
		sql.append("        c.should_num    AS shouldNum,  ");
		sql.append("        c.real_num      AS realNum,  ");
		sql.append("        c.pass_num      aspassNum,  ");
		sql.append("        c.nopass_num    AS nopassNum,  ");
		sql.append("        c.giveup_num    AS giveupNum,  ");
		sql.append("        c.meeting_place AS meetingPlace,  ");
		sql.append("        c.CREATE_TIME AS CREATETIME,  ");
		sql.append("        c.MEETING_FORMAT AS MEETINGFORMAT,  ");
		sql.append("        case  when D.MEETING_ID=A.MEETING_ID  then  '是'  else   '否'  end  feeSatus,  ");
		sql.append("        case  when E.SESSION_ID=A.MEETING_ID  then  '是'  else   '否'  end  sessionSatus,  ");
		sql.append("        case  when F.MEETING_ID=A.MEETING_ID  then  '是'  else   '否'  end  ruleSatus   ");
		sql.append("   FROM SOM_ELECTION A,  ");
		sql.append("        SOM_APPLY    B,  ");
		sql.append("        SOM_MEETING  C,  ");
		sql.append("        SOM_FEE      D,  ");
		sql.append("        SOM_SESSION  E,  ");
		sql.append("        SOM_RULE     F  ");
		sql.append("  WHERE A.TASK_CODE = B.TASK_CODE  ");
		sql.append("    AND B.IF_FINISH = '1'  ");
		sql.append("    AND A.MEETING_ID = C.MEETING_ID  ");
		sql.append("    AND A.MEETING_ID = d.MEETING_ID(+)  ");
		sql.append("    AND A.MEETING_ID = E.SESSION_ID(+)  ");
		sql.append("    AND A.MEETING_ID = F.MEETING_ID(+)  ");
		sql.append("    AND A.SORG_ID = ?  ");
		sql.append("    ORDER BY C.CREATE_TIME  DESC");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		argsList.add(sorgId);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(), types, args,  true);
		return ds;
	}

}
